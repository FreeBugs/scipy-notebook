# scipy-notebook
## Single-user scipy notebook for docker swarm spawner usage, supporting homes on network shares, ssh and more

We are using this with jupyterhub and the swarm spawner.

This notebook utilizes the new JUPYTER_ALLOW_INSECURE_WRITES env variable to allow user homes on network 
shares that do not support chmod operations (such as cifs).
We have also included ssh for convenient pushing and pulling git repos.
