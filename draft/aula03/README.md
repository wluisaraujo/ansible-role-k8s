Conteúdo da Aula 03
--------------

 * [step03](path/file.md)

# vim primeiro-deployment.yaml

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: nginx
    app: giropops
  name: primeiro-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      run: nginx
  template:
    metadata:
      labels:
        run: nginx
        dc: UK
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx2
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
    

# kubectl create -f primeiro-deployment.yaml
deployment.extensions/primeiro-deployment created
--------------

# vim segundo-deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: nginx
  name: segundo-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      run: nginx
  template:
    metadata:
      labels:
        run: nginx
        dc: Netherlands
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx2
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      

# kubectl create -f segundo-deployment.yaml
deployment.extensions/segundo-deployment created
--------------

hisotory

# kubectl get deployment

# kubectl get pods

# kubectl describe pod primeiro-deployment-68c9dbf8b8-kjqpt

# kubectl describe pod segundo-deployment-59db86c584-cf9pp

# kubectl describe deployment primeiro-deployment

# kubectl describe deployment segundo-deployment
--------------


Comandos - Labels

# kubectl get pods -l dc=UK

# kubectl get pods -l dc=Netherlands

# kubectl get pod -L dc

# kubectl label nodes elliot-02 dc-

# kubectl label nodes --all dc-

# kubectl label node elliot-02 disk=SSD

# kubectl label node elliot-02 dc=UK

# kubectl label node elliot-03 dc=Netherlands

# kubectl label nodes elliot-03 disk=hdd

# kubectl label nodes elliot-03 disk=HDD --overwrite

# kubectl label nodes elliot-02 --list

# kubectl label nodes elliot-03 --list
--------------

# vim terceiro-deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: nginx
  name: terceiro-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      run: nginx
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx
        dc: Netherlands
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx2
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      nodeSelector:
        disk: SSD


# kubectl create -f terceiro-deployment.yaml
deployment.extensions/terceiro-deployment created

# kubectl get pods -o wide
--------------


# vim primeiro-replicaset.yaml
apiVersion: extensions/v1beta1
kind: ReplicaSet
metadata:
  name: replica-set-primeiro
spec:
  replicas: 3
  template:
    metadata:
      labels:
        system: Giropops
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80

# kubectl create -f primeiro-replicaset.yaml

# kubectl get replicaset

history

# kubectl describe rs replica-set-primeiro

# kubectl delete pod replica-set-primeiro-6drmt

# kubectl get pods -l system=Giropops

# kubectl edit rs replica-set-primeiro

# kubectl get pods -l system=Giropops

# kubectl get deployment

# kubectl delete pod replica-set-primeiro-7j59w

# kubectl describe pod replica-set-primeiro-xzfvg

# kubectl get rs

# kubectl delete rs replica-set-primeiro
--------------



# vim primeiro-daemonset.yaml
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: daemon-set-primeiro
spec:
  template:
    metadata:
      labels:
        system: Strigus
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80

# kubectl taint nodes --all node-role.kubernetes.io/master-

# kubectl create -f  primeiro-daemonset.yaml

# kubectl get daemonset

# kubectl describe ds daemon-set-primeiro

# kubectl get pods -o wide

# kubectl set image ds daemon-set-primeiro nginx=nginx:1.15.0

# kubectl describe ds daemon-set-primeiro

# kubectl delete pod daemon-set-primeiro-jh2sp
--------------


history

# kubectl rollout history ds daemon-set-primeiro

# kubectl rollout history ds daemon-set-primeiro --revision=1

# kubectl rollout history ds daemon-set-primeiro --revision=2

# kubectl rollout undo ds daemon-set-primeiro --to-revision=1

# kubectl rollout status ds daemon-set-primeiro 

# kubectl describe daemon-set-primeiro-hp4qc | grep -i image:

# kubectl delete -f primeiro-daemonset.yaml
--------------

# vim primeiro-daemonset.yaml

apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: daemon-set-primeiro
spec:
  template:
    metadata:
      labels:
        system: DaemonOne
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
  updateStrategy:
    type: RollingUpdate
--------------    
    
# kubectl create -f primeiro-daemonset.yaml

# kubectl get daemonset

# kubectl describe ds daemon-set-primeiro

# kubectl get ds daemon-set-primeiro -o yaml | grep -A 2 Strategy

# kubectl set image ds daemon-set-primeiro nginx=nginx:1.15.0

# kubectl get daemonset

# kubectl get pods -o wide

# kubectl describe ds daemon-set-primeiro

# kubectl rollout history ds daemon-set-primeiro

# kubectl rollout history ds daemon-set-primeiro --revision=1

# kubectl rollout history ds daemon-set-primeiro --revision=2

# kubectl rollout undo ds daemon-set-primeiro --to-revision=1

# kubectl rollout status ds daemon-set-primeiro

# kubectl delete ds daemon-set-primeiro

--------------

