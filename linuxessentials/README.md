Linux essentials - FIRST TASk

commands done in terminal ( can be taken with copy/paste ).

First run in the terminal:

 sudo docker run -it -p 8080:8080 ubuntu
 
Then:

apt update && apt install -y dnsutils netcat-traditional nginx nano
nslookup cloudflare.com
echo "8.8.8.8 google-dns" >> /etc/hosts
cat /etc/hosts
nc -zv google-dns 53
echo "nameserver 8.8.8.8" > /etc/resolv.conf
cat /etc/resolv.conf
nslookup cloudflare.com
ss -tulnp | grep nginx 

Cat ony to verify.

Now, we change with nano the files:

First the port for nginx at:

nano /etc/nginx/sites-available/default

There is a line there the first one: changed to 8080

Then for the text of the site we access: (same thing as before)

nano /var/www/html/index.nginx-debian.html

At the end we start the server, otherwise it gave me something with server keep restarting, if i tried changing after i start the server even if i restart it.

service nginx start

SOME ISSUES HAD:
1. the one with nginx that even restarted it wouldnt work, if i nano the text after.
2. On my ubuntu, docker wouldnt run, so i had to use the vm ubuntu i had.

thats it

Mihnea

