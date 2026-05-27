# See the current parent group 
id
id -gn # Only name of main group
#Create file and see which group inherits
touch ~/test_grupo_heredado.txt
ls -la ~/test_grupo_heredado.txt
# Results
# -rw-r--r-- 1 root root 0 may 27 12:56 /root/test_grupo_heredado.txt
# The group is the main group of user.