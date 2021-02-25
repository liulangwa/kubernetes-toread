# EFK

elasticsearch fluentd kibana

### docker 日志文件的路径
 

`/var/log/containers`

```
#ls -l /var/log/containers

lrwxrwxrwx 1 root root 126 Feb 20 15:37 nginx-ingress-controller-gnkmt_ingress-nginx_nginx-ingress-controller-901327e40f3992c61a1d7455a0691d1d1563e0d69998f6765cb6fd0fbdad9642.log -> /var/log/pods/ingress-nginx_nginx-ingress-controller-gnkmt_03f3eb1f-ccee-44d9-bc14-213f5d58363f/nginx-ingress-controller/9.log
```
container里面的文件是软连接，实际日志都在目录 `/var/log/pods/`

### efk 部署

服务部署使用下面提供的yaml，只需要修改两个地方
1 podsecurity的设置要删掉
2 kibana的环境变量需要注释掉，这个是使用kube-proxy 方式访问kibna时候使用的变量 name: SERVER_BASEPATH

https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch

### 测试es是否健康

```
#curl 10.42.0.60:9200/_cluster/health?pretty

{
  "cluster_name" : "kubernetes-logging",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 1,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 66.66666666666666
}
```