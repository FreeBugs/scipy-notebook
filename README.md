# scipy-notebook
## Single-user scipy notebook with JupyterLab.
__Can be used locally or for docker swarm spawner usage, supporting homes on network shares, ssh and more!__

### Included packages
|                | Version
|----------------|---------
| jupyterlab-git | 0.9
| matplotlib     | 3.1
| numpy          | 1.18
| nltk           | 3.4
| pandas         | 1.0
| scikit-learn   | 0.22
| tensorflow     | 2.1

Report issues here: https://github.com/FreeBugs/scipy-notebook/issues
Docker images can be found here: https://hub.docker.com/r/darnold79/scipy-notebook

### How to run on your local machine
You do not need to use the hub to run this image. To run the container locally:
```shell
docker run -d -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes \
  --mount type=bind,source=/home/user/jupyterlab,target=/home/jovyan \
  --name scipy-notebook darnold79/scipy-notebook:test
```
You need to replace /home/user/jupyterlab with the directory you want to share with the jupyterlab container. On macOS this will be something like /Users/username/somedirectory, on Windows C:\Users\User\somedirectory. The directory has to be created before you can start the container.

After the container started, to retrieve the access token:
```shell
docker container logs scipy-notebook  
```
Which should give you an output similar to this one:
```
To access the notebook, open this file in a browser:
    file:///home/jovyan/.local/share/jupyter/runtime/nbserver-7-open.html
Or copy and paste one of these URLs:
    http://6968edc5f4b3:8888/?token=b60d25b9sometokenc9c29e1fb2
 or http://127.0.0.1:8888/?token=b60d25b9sometokenc9c29e1fb2
```
Copy the 127.0.0.1 URL to your browser and you are all set.

### Use with swarm spawner
We are using this with jupyterhub and the swarm spawner.
This notebook utilizes the new JUPYTER_ALLOW_INSECURE_WRITES env variable to allow user homes on network
shares that do not support chmod operations (such as cifs).
We have also included ssh for convenient pushing and pulling git repos.
