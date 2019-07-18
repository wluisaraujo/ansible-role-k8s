Conteúdo da Aula 04
--------------

 * [step04](path/file.md)

# vim pod-emptydir.yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: default
spec:
  containers:
  - image: busybox
    name: busy
    command:
      - sleep
      - "3600"
    volumeMounts:
    - mountPath: /giropops
      name: giropops-dir
  volumes:
  - name: giropops-dir
    emptyDir: {}
--------------

# kubectl create -f pod-emptydir.yaml

# kubectl get pod

# kubectl exec -ti busybox -c busy -- touch /giropops/funciona

# kubectl exec -ti busybox -c busy -- ls -l /giropops/

# kubectl get pod -o wide

# find /var/lib/kubelet/pods/ -iname giropops-dir

# ls /var/lib/kubelet/pods/7d...kubernetes.io~empty-dir/giropops-dir

# kubectl delete -f pod-emptydir.yaml

# ls /var/lib/kubelet/pods/7d...kubernetes.io~empty-dir/giropops-dir
--------------

# apt-get install nfs-kernel-server -y

# sudo yum install nfs-utils -y

# apt-get install -y nfs-common

# mkdir /opt/giropops

# chmod 1777 /opt/giropops/

# vim /etc/exports
/opt/giropops *(rw,sync,no_root_squash,subtree_check)

# exportfs -ra

# touch /opt/giropops/FUNCIONA
--------------

# vim primeiro-pv.yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: primeiro-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    path: /opt/giropops
    server: 10.138.0.2
    readOnly: false
--------------

# kubectl create -f primeiro-pv.yaml

# kubectl get pv

# kubectl describe pv primeiro-pv
--------------

# vim primeiro-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: primeiro-pvc
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 800Mi
--------------

# kubectl create -f primeiro-pvc.yaml

# kubectl get pv

# kubectl get pvc
--------------

# vim nfs-pv.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: default
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      run: nginx
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      labels:
        run: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        volumeMounts:
        - name: nfs-pv
          mountPath: /giropops
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      volumes:
      - name: nfs-pv
        persistentVolumeClaim:
          claimName: primeiro-pvc
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
--------------

# kubectl create -f nfs-pv.yaml

# kubectl describe deployment nginx

# kubectl get pods -o wide

# kubectl describe pod nginx-b4bd77674-gwc9k

# kubectl exec -ti nginx-b4bd77674-gwc9k -- ls /giropops/

# kubectl exec -ti nginx-b4bd77674-gwc9k -- touch /giropops/STRIGUS

# kubectl exec -ti nginx-b4bd77674-gwc9k -- ls -la  /giropops/

# ls -la /opt/giropops/

# kubectl get deployment

# kubectl delete deployment nginx

#ls -la /opt/giropops/
--------------	  

# vim primeiro-cron.yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: giropops-cron
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: giropops-cron
            image: busybox
            args:
            - /bin/sh
            - -c
            - date; echo Bem Vindo ao Descomplicando Kubernetes - LinuxTips VAIIII ;sleep 30
          restartPolicy: OnFailure
--------------

# kubectl create -f primeiro-cron.yaml

# kubectl get cronjobs

# kubectl describe cronjobs.batch giropops-cron

# kubectl get jobs --watch

# kubectl get cronjob giropops-cron

# kubectl get pods

#kubectl  logs giropops-cron-1534979940-vcwdg

# kubectl get pods

# kubectl delete cronjob giropops-cron
--------------

# echo -n "descomplicando-k8s" > secret.txt

# kubectl create secret generic my-secret --from-file=secret.txt

# kubectl describe secret my-secret

# kubectl get secret

# kubectl get secret my-secret -o yaml

# echo 'ZGVzY29tcGxpY2FuZG8tazhz' | base64 --decode
--------------

# vim pod-secret.yaml
apiVersion: v1
kind: Pod
metadata:
  name: teste-secret
  namespace: default
spec:
  containers:
  - image: busybox
    name: busy
    command:
      - sleep
      - "3600"
    volumeMounts:
    - mountPath: /tmp/giropops
      name: my-volume-secret
  volumes:
  - name: my-volume-secret
    secret:
      secretName: my-secret
--------------

# kubectl create -f pod-secret.yaml

# kubectl exec -ti teste-secret -- ls /tmp/giropops

# kubectl exec -ti teste-secret -- cat /tmp/giropops/secret.txt

# kubectl create secret generic my-literal-secret --from-literal user=linuxtips --from-literal password=catota

# kubectl describe secret my-literal-secret	  
--------------

# vim pod-secret-env.yaml
apiVersion: v1
kind: Pod
metadata:
  name: teste-secret-env
  namespace: default
spec:
  containers:
  - image: busybox
    name: busy-secret-env
    command:
      - sleep
      - "3600"
    env:
    - name: MEU_USERNAME
      valueFrom:
        secretKeyRef:
          name: my-literal-secret
          key: user
    - name: MEU_PASSWORD
      valueFrom:
        secretKeyRef:
          name: my-literal-secret
          key: password 
--------------

# kubectl create -f pod-secret-env.yaml

# kubectl exec teste-secret-env -c busy-secret-env -it -- printenv
--------------

# mkdir frutas

# echo amarela > frutas/banana

# echo vermelho > frutas/morango

# echo verde > frutas/limao

# echo "verde e vermelha" > frutas/melancia

# echo kiwi > predileta

# git clone https://bitbucket.org/gcalcette/book-descomplicando-k8s.git

# kubectl create configmap cores-frutas --from-literal=uva=roxa --from-file=predileta --from-file=frutas/

# kubectl get configmap
--------------

# vim pod-configmap.yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox-configmap
  namespace: default
spec:
  containers:
  - image: busybox
    name: busy-configmap
    command:
      - sleep
      - "3600"
    env:
    - name: frutas
      valueFrom:
        configMapKeyRef:
          name: cores-frutas
          key: predileta
#    envFrom:
#    - configMapRef:
#        name: cores-frutas
--------------

# kubectl create -f pod-configmap.yaml
--------------

# cat pod-configmap-file.yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox-configmap-file
  namespace: default
spec:
  containers:
  - image: busybox
    name: busy-configmap
    command:
      - sleep
      - "3600"
    volumeMounts:
    - name: meu-configmap-vol
      mountPath: /etc/frutas
  volumes:
  - name: meu-configmap-vol
    configMap:
      name: cores-frutas
--------------

# kubectl create -f pod-configmap-file.yaml
--------------

# vim nginx-initcontainer.yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-demo
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - name: workdir
      mountPath: /usr/share/nginx/html
  initContainers:
  - name: install
    image: busybox
    command:
    - wget
    - "-O"
    - "/work-dir/index.html"
    - http://kubernetes.io
    volumeMounts:
    - name: workdir
      mountPath: "/work-dir"
  dnsPolicy: Default
  volumes:
  - name: workdir
    emptyDir: {}
--------------

# kubectl create -f nginx-initcontainer.yaml

# kubectl exec -ti init-demo -- cat /usr/share/nginx/html/index.html

# kubectl describe pod init-demo
--------------

# kubectl create serviceaccount jeferson

# kubectl create clusterrolebinding toskeria --serviceaccount=default:jeferson --clusterrole=cluster-admin
--------------

# vim admin-user.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
--------------

# vim admin-cluster-role-binding.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
--------------

# kubectl create -f admin-user.yaml

# kubectl create -f admin-cluster-role-binding.yaml
--------------

# wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz

# tar -vxzf helm-v2.11.0-linux-amd64.tar.gz

# cd linux-amd64/

# mv helm /usr/local/bin/

# mv tiller /usr/local/bin/

# helm init

# kubectl create serviceaccount --namespace=kube-system tiller

# kubectl create clusterrolebinding tiller-cluster-role --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

# kubectl patch deployments -n kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

# helm install --namespace=monitoring --name=prometheus --version=7.0.0 --set alertmanager.persistentVolume.enabled=false,server.persistentVolume.enabled=false stable/prometheus

# helm list

# helm search grafana

# helm install --namespace=monitoring --name=grafana --version=1.12.0 --set=adminUser=admin,adminPassword=admin,service.type=NodePort stable/grafana

# helm list

# kubectl  get deployments.

# kubectl  get service

# helm delete prometheus

# helm delete grafana

# helm list

# helm reset
--------------