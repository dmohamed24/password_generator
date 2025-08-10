              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd

              sudo tee /var/www/html/index.html > /dev/null <<EOT
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <title>Welcome to My EC2 Site</title>
                  <style>
                      body { background-color: #f0f0f0; font-family: Arial, sans-serif; text-align: center; padding-top: 50px; }
                      h1 { color: #333; }
                      p { color: #666; }
                  </style>
              </head>
              <body>
                  <h1>Hello from EC2!</h1>
                  <h1>UPDATE IS WORKING finally ???!!!!!!!!! </h1>
                  <p>Deployed with Terraform and Apache</p>
              </body>
              </html>
              EOT