# elk

this cluster base on zookeeper and kafka

```
|app+filebeat|->|kafka|->|logstash|->|es|
```

### config filebeak

```
data:
  filebeat.yml: |-
    filebeat.inputs:
    - input_type: log
      paths:
        - /data/log/*/*.log
      tail_files: true
      fields:
        pod_name: '${podName}'
        pod_ip: '${podIp}'
        pod_deploy_name: '${podDeployName}'
        pod_namespace: '${podNamespace}'
      tags: [app-filebeat] 
    output.kafka:
      hosts: ["kafka.middleware:9092"]
      topic: "app-filebeat"
      codec.json:
        pretty: false
      keep_alive: 30s
```
paths 配置了收集日志的路径 fields配置了日志收集后的字段
output.kafka.hosts 配置了kafka服务器的地址 output.kafka.topic 配置了日志的topic

### create log by hand

手动模拟日志写入

```
kubectl exec -it app-89487cc78-qsm8z  -c app -- sh
cd /home/tomcat/target
echo `date` >> app.log
```

### get log from kakfa topic app-filebeat

这个时候kafka的topic应该就可以读取到消息了

```
kafka-console-consumer.sh  --bootstrap-server kafka.middleware.svc.cluster.local:9092 --topic app-filebeat --from-beginning
```

### 配置logstash 转发kafka的消息到elasticsearch

input 配置从kafka拉取消息
output 配置写入es的信息

```
  logstash.conf: |
    # all input will come from filebeat, no local logs
    input {
      kafka {
              enable_auto_commit => true
              auto_commit_interval_ms => "1000"
              bootstrap_servers => "kafka.middleware:9092"
              topics => ["app-filebeat"]
              codec => json
          }
    }

    output {
       stdout{ codec=>rubydebug}
       if [fields][pod_namespace] =~ "default" {
           elasticsearch {
             hosts => ["elasticsearch-logging:9200"]
             index => "%{[fields][pod_namespace]}-s-%{+YYYY.MM.dd}"
          }
       } else {
          elasticsearch {
             hosts => ["elasticsearch-logging:9200"]
             index => "no-index-%{+YYYY.MM.dd}"
          }
       }
    }
```

### kibana


创建index_patterns搜索日志

http://kibana.local.io:8080/app/kibana#/management/kibana/index_patterns?_g=()


### ref
>https://www.docker.elastic.co/r/logstash/logstash
