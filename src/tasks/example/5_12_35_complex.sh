echo 'Return-path: <sender@example.com>
To: stateauthority@example.com
From: Your Name <sender@example.com>
Subject: Your Annoying Mail
Date: '"${DATE}"'
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Content-Type: text/plain; charset=utf-8

Hello <NAME>
'
cat "./partials/$(ls ./partials/ | shuf -n1)"
echo '
Cheers
<MY_NAME>

'
