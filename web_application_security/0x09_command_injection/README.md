# 0x09. Command Injection

## Description

This project focuses on identifying and exploiting command injection vulnerabilities in a controlled lab environment.

Command injection happens when an application passes unsanitized user input into an operating system command. In this project, the vulnerable functionality was the ping feature inside the Asset Discovery Tool.

## Target

Initial endpoint:

```text
http://web0x09.hbtn/app1/
cd ~/holbertonschool-cyber_security

mkdir -p web_application_security/0x09_command_injection

cat > web_application_security/0x09_command_injection/README.md << 'EOF'
# 0x09. Command Injection

## Description

This project focuses on identifying and exploiting command injection vulnerabilities in a controlled lab environment.

Command injection happens when an application passes unsanitized user input into an operating system command. In this project, the vulnerable functionality was the ping feature inside the Asset Discovery Tool.

## Target

Initial endpoint:

http://web0x09.hbtn/app1/

## Task 0

The ping input was vulnerable to command injection.

A normal input such as google.com confirmed that the ping feature worked.

Command injection was confirmed using:

google.com;id

The application executed the injected id command and returned:

uid=999(lab01) gid=999(lab01) groups=999(lab01)

The flag was retrieved from /0-flag.txt using:

google.com;cat${IFS}/0-flag.txt

## Result

The discovered flag is stored in 0-flag.txt.
