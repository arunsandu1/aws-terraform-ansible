
### Initial Setup
1. Run `./run_setup.sh` to setup required aws config and install packages.
2. Run `terraform init && terraform plan`
3. Review the plan and run `terraform apply`


### Password less access
1. Run `ssh-copy-id root@server_ip_address`
or
2.  To enable password less ssh access. Copy the pub-key. [if pub-key is not available run to create one `ssh-keygen -t rsa`]
```
cat ~/.ssh/id_rsa.pub | ssh-copy-id root@server_ip_address "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```


### Disabling SSH Password Authentication
1. Log into your remote server with SSH keys, either as a user with sudo privileges or root:
`ssh sudo_user@server_ip_address`

2. Open the SSH configuration file `/etc/ssh/sshd_config`, search for the following directives and modify as it follows: Copy and save the file and restart the SSH service.

```
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
```
3. On Ubuntu or Debian servers, run the following command:
`sudo systemctl restart ssh`
4. On CentOS or Fedora servers, run the following command:
`sudo systemctl restart sshd`
