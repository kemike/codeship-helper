# Codeship helper
Source image:  
- https://github.com/codeship-library/kubectl  
- https://hub.docker.com/r/codeship/eks-kubectl  

Features:  
- AWS cli  #AWS cli access
- Kubectl  #kubectl access
- Helm  #helm access
- aws-authenticator  #for ECR push
- ensubstvars_helper.sh  #helper script for build time envsubst based operations

# Kubectl configuration
- https://github.com/codeship-library/kubectl  

To enable using kubectl in CodeshipPro builds kubectl configuration must be accessible. It can be passsed
to the container via encrypted variables in codeship-services.yaml.

Setting up encrypted kubectl config for codeship deployments:  
```
$: kubectl config view --flatten > kubeconfigdata # add --minify flag to reduce info to current context
$: docker run --rm -it -v $(pwd):/files codeship/env-var-helper cp kubeconfigdata:/root/.kube/config k8s-env
$: jet encrypt k8s-env k8s-env.encrypted
$: mcedit k8s-env #add AWS credetials to k8s-env file
$: rm kubeconfigdata k8s-env
```

In codeship:  
(from the folder where Chart.yaml found with name 'my-deployment')
```
#codeship-services.yml
kubectl:
  image: komiszkrissz/codeship-helper
  cached: true
  default_cache_branch: "develop"
  encrypted_env_file: k8s-env.encrypted
  volumes:
    - ./:/deploy
```
```
#codeship-services.yml
- name: Deploy
  service: kubectl
  tag: develop
  command: helm upgrade my-deployment /deploy'
```