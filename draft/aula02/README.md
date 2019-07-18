Conteúdo da Aula 02
--------------

 * [step02](path/file.md)

Add-ons:
https://kubernetes.io/docs/concepts/cluster-administration/networking/
https://chrislovecnm.com/kubernetes/cni/choosing-a-cni-provider/
https://kubernetes.io/docs/concepts/cluster-administration/addons/

# vim primeiro-service-clusterip.yaml:

apiVersion: v1
kind: Service
metadata:
  labels:
    run: nginx
  name: nginx-clusterip
  namespace: default
spec:
  externalTrafficPolicy: Cluster
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
  sessionAffinity: None
  type: ClusterIP
  
# vim primeiro-service-nodeip.yaml:

apiVersion: v1
kind: Service
metadata:
  labels:
    run: nginx
  name: nginx-nodeport
  namespace: default
spec:
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 32548
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
  sessionAffinity: ClientIP
  type: NodePort

# vim primeiro-service-loadbalancer.yaml:

apiVersion: v1
kind: Service
metadata:
  labels:
    run: nginx
  name: nginx-loadbalancer
  namespace: default
spec:
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 32548
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
  sessionAffinity: None
  type: LoadBalancer

# kubectl create -f primeiro-service-clusterip.yaml

# kubectl create -f primeiro-service-nodeip.yaml

# kubectl create -f primeiro-service-loadbalancer.yaml

# kubectl edit -f primeiro-service-nodeip.yaml

# kubectl get deploy nginx -o yaml > primeiro-deployment-limitado.yaml

# kubectl exec -ti nginx-limitado-8d767cd5f-lg5xs -- /bin/bash

# kubectl replace -f deployment_limitado.yaml

# kubectl get endpoints

# kubectl describe endpoints nginx-ddswrgb

# vim deployment-limitado.yaml


apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: nginx
  name: nginx-limitado
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 2
  selector:
    matchLabels:
      run: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        ports:
        - containerPort: 80
          protocol: TCP
        resources:
          limits:
            memory: 128Mi
            cpu: 1
          requests:
            memory: 96Mi
            cpu: 1
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30

# vim limitando-recursos.yaml:

apiVersion: v1
kind: LimitRange
metadata:
  name: limitando-recursos
spec:
  limits:
  - default:
      cpu: 1
      memory: 100Mi
    defaultRequest:
      cpu: 0.5
      memory: 80Mi
    type: Container


# vim pod-limitrange.yml

apiVersion: v1
kind: Pod
metadata:
  name: pod-limitrange
spec:
  containers:
    - name: limitado-pod
      image: nginx
	  

# kubectl create namespace primeiro-namespace

# kubectl get ns

# kubectl describe primeiro-namespace

# kubectl describe namespace primeiro-namespace

# kubectl create -f limitando-recursos.yaml -n primeiro-namespace

# kubectl get limitranges

# kubectl get limitranges -n primeiro-namespace

# kubectl get limitranges --all-namespace

# kubectl describe limitranges -n primeiro-namespace

# kubectl create -f pod-limitrange.yaml

# kubectl create -f pod-limitrange.yaml -n primeiro-namespace

# kubectl get pods --all-namespaces

#kubectl describe pod limit-pod

# kubectl describe pod limit-pod -n primeiro-namespace

# kubectl describe nodes elliot-01 | grep -i taint
Taints:             node-role.kubernetes.io/master:NoSchedule

# kubectl describe nodes  | grep -i taints

# kubectl taint node elliot-01 node-role.kubernetes.io/master:NoSchedule-

# kubectl taint node elliot-01 node-role.kubernetes.io/master:NoSchedule

# kubectl taint node elliot-02 key1=value1:NoSchedule

# kubectl taint node elliot-02 key1=value1:NoSchedule-

# kubectl get pods -o wide

# kubectl taint node elliot-02 key1=value1:NoExecute-

# kubectl taint node elliot-02 key1=value1:NoExecute

# kubectl get pods -o wide

# kubectl taint node all key1=value1:NoExecute

History - Day2
	  
kubectl get nodes
kubectl get pods --all-namespaces
kubectl get nodes
kubectl describe node elliot-01
kubectl describe node elliot-02
source <(kubectl completion bash)
kubectl describe nodes elliot-03
echo "source <(kubectl completion bash)" >> /root/.bashrc
kubectl get namespaces
kubectl get pods -n kube-system
kubectl get pods -n kube-system -o wide
history
kubectl run nginx --image nginx
kubectl get deployments.
kubectl get replicasets.
kubectl get pods
kubectl get services
kubectl describe replicasets. nginx-7cdbd8cdc9
kubectl describe pods nginx-7cdbd8cdc9-zzp8n
kubectl get deployments.
kubectl describe deployments. nginx
kubectl get deployments.
kubectl scale --replicas=10 deployment nginx
kubectl get deployments.
kubectl run nginx2 --image nginx
kubectl get deployments.
kubectl describe deployments. nginx
kubectl get pods
kubectl get deployments.
kubectl delete deployments. nginx
kubectl delete deployments. nginx2
kubectl get deployments.
kubectl run nginx --image nginx --port=80
kubectl get deployments.
kubectl describe pods nginx-57867cc648-q8zkj
kubectl get deployments. nginx -o yaml
kubectl get deployments. nginx
kubectl get deployments. nginx -o yaml
kubectl get deployments. nginx -o yaml > meu_primeiro_deployment.yaml
ls
vim meu_primeiro_deployment.yaml
ls
kubectl get deployments.
kubectl create -f meu_primeiro_deployment.yaml
kubectl get deployments.
kubectl delete -f meu_primeiro_deployment.yaml
vim meu_primeiro_deployment.yaml
kubectl create -f meu_primeiro_deployment.yaml
kubectl get deployments.
kubectl get pods
kubectl get deployments.
kubectl expose deployment meu-nginx
kubectl get services
kubectl delete service meu-nginx
kubectl expose deployment meu-nginx --type=NodePort
kubectl get services
kubectl get services
kubectl get services -o yaml
kubectl get services -o yaml > meu_primeiro_service.yaml
vim meu_primeiro_service.yaml
rm -rf meu_primeiro_service.yaml
kubectl get services nginx -o yaml > meu_primeiro_service.yaml
vim meu_primeiro_service.yaml
kubectl delete service nginx
kubectl create -f meu_primeiro_service.yaml
kubectl get services
kubectl delete service nginx
vim meu_primeiro_service.yaml
kubectl delete service nginx
kubectl get services
kubectl expose deployment nginx --type=NodePort
kubectl get services
curl 10.99.152.147
curl http://3.90.64.138:32144/
curl 10.99.152.147
kubectl describe service nginx
kubectl get services nginx -o yaml > meu_primeiro_service_nodeport.yaml
vim meu_primeiro_service_nodeport.yaml
kubectl create -f meu_primeiro_service_nodeport.yaml
kubectl delete service nginx
kubectl create -f meu_primeiro_service_nodeport.yaml
kubectl get services
vim meu_primeiro_service_nodeport.yaml
history
vim meu_primeiro_service_nodeport.yaml
kubectl delete service nginx
kubectl expose deployment nginx --type=LoadBalancer
kubectl get services
kubectl get endpoints
kubectl get services nginx -o yaml > meu_primeiro_service_loadbalancer.yaml
vim meu_primeiro_service_nodeport.yaml
vim meu_primeiro_service_loadbalancer.yaml
kubectl delete service nginx
kubectl create -f meu_primeiro_service_loadbalancer.yaml
kubectl get services
kubectl get endpoints
kubectl describe endpoints nginx
vim meu_primeiro_deployment.yaml
kubectl delete deployments. nginx
kubectl create -f meu_primeiro_deployment.yaml
kubectl delete deployments. nginx
kubectl delete -f meu_primeiro_deployment.yaml
kubectl delete service nginx
cat meu_primeiro_service_nodeport.yaml
vim meu_primeiro_deployment.yaml
kubectl create -f meu_primeiro_deployment.yaml
vim meu_primeiro_deployment.yaml
cp meu_primeiro_deployment.yaml deployment_limitado.yaml
vim deployment_limitado.yaml
kubectl create -f deployment_limitado.yaml
kubectl delete deployments. meu-nginx
kubectl create -f deployment_limitado.yaml
kubectl get deployments.
kubectl describe deployments. meu-nginx
kubectl create -f deployment_limitado.yaml
kubectl replace -f deployment_limitado.yaml
kubectl create -f meu_primeiro_service.yaml
kubectl delete service nginx
kubectl create -f meu_primeiro_service.yaml
kubectl get services
vim meu_primeiro_service.yaml
kubectl edit service nginx
kubectl get services
kubectl edit service nginx
kubectl get services
kubectl edit deployments. meu-nginx
kubectl get deployments.
kubectl get replicasets.
kubectl edit deployments. meu-nginx
kubectl get deployments.
kubectl edit deployments. meu-nginx
history
vim deployment_limitado.yaml
kubectl get deployments.
kubectl get pods
kubectl get pods -o wide
kubectl exec -ti meu-nginx-79d7766cb8-2shml -- bash
kubectl edit deployments. meu-nginx
kubectl delete deployments. meu-nginx
kubectl delete service nginx
kubectl get namespaces
kubectl create namespace giropops
kubectl get namespaces
kubectl describe namespaces giropops
kubectl get namespaces giropops -o yaml
kubectl get namespaces giropops -o yaml > meu_primeiro_namespace.yaml
vim meu_primeiro_namespace.yaml
kubectl create -f meu_primeiro_namespace.yaml
kubectl get namespaces
vim namespace_limitado.yaml
  history
cat namespace_limitado.yaml
kubectl create -f namespace_limitado.yaml -n giropops
kubectl get limitranges
kubectl get limitranges -n giropops
kubectl describe limitranges -n giropops limitando-recursos
vim pod-limitado.yaml
vim meu_primeiro_deployment.yaml
vim pod-limitado.yaml
kubectl create -f pod-limitado.yaml
kubectl delete -f pod-limitado.yaml
kubectl delete -f pod-limitado.yaml -n giropops
kubectl create -f pod-limitado.yaml -n giropops
kubectl get pods
kubectl get pods -n giropops
kubectl describe pods -n giropops
vim namespace_limitado.yaml
kubectl delete -f pod-limitado.yaml
kubectl get deployments. --all-namespaces
kubectl describe nodes elliot-02
kubectl describe nodes elliot-01
kubectl create -f deployment_limitado.yaml
kubectl get deployments. --all-namespaces
kubectl get pods -o wide
kubectl scale --replicas=6 deployment nginx
kubectl scale --replicas=6 deployment meu-nginx
kubectl get pods -o wide
kubectl taint node  elliot-02 key1=value1:NoSchedule
kubectl describe nodes elliot-02
kubectl scale --replicas=10 deployment meu-nginx
kubectl get namespaces
kubectl get deployments.
kubectl edit deployments. meu-nginx
kubectl get deployments.
kubectl get pods -o wide
kubectl delete deployments. meu-nginx
kubectl taint node  elliot-02 key1:NoSchedule-
vim deployment_limitado.yaml
kubectl create -f deployment_limitado.yaml
kubectl get pods -o wide
kubectl delete deployments. meu-nginx
vim deployment_limitado.yaml
kubectl create -f deployment_limitado.yaml
kubectl get deployments.
kubectl get pods -o wide
kubectl taint node  elliot-02 key1=value1:NoSchedule
kubectl get pods -o wide
kubectl scale --replicas=10 deployment meu-nginx
kubectl get pods -o wide
kubectl delete deployments. meu-nginx
kubectl taint node  elliot-02 key1:NoSchedule-
kubectl create -f deployment_limitado.yaml
kubectl get pods -o wide
kubectl taint node  elliot-02 key1=value1:NoExecute
kubectl get pods -o wide
kubectl taint node  elliot-02 key1:NoExecute-
kubectl get pods -o wide
kubectl taint node  elliot-02 key1=value1:NoExecute
kubectl describe nodes elliot-02
kubectl taint node  elliot-02 key1:NoExecute-
kubectl get pods -o wide
kubectl scale --replicas=1 deployment meu-nginx
kubectl scale --replicas=6 deployment meu-nginx
kubectl get pods -o wide

	  

  