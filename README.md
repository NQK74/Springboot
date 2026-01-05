## Setup

1. Clone project
2. Tạo file `src/main/resources/application.properties`:
spring.jpa.hibernate.ddl-auto=update
spring.datasource.url=jdbc:mysql://${MYSQL_HOST:localhost}:3306/laptopshop
spring.datasource.username=root
spring.datasource.password=${DB_PASSWORD:}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.show-sql=true

spring.servlet.multipart.max-file-size=50MB
spring.servlet.multipart.max-request-size=50MB

spring.session.store-type=jdbc
spring.session.jdbc.initialize-schema=always
spring.session.timeout=30m

# Email Configuration
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=${MAIL_USERNAME:}
spring.mail.password=${MAIL_PASSWORD:}
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true

# VNPay Configuration (Sandbox - Public demo)
vnpay.tmn-code=O4ZDXSLW
vnpay.hash-secret=PMGNGB19LHGAM5G3JVEEWPFG87MZVNCX
vnpay.payment-url=https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
vnpay.return-url=http://localhost:8080/vnpay/payment-return
vnpay.api-url=https://sandbox.vnpayment.vn/merchant_webapi/api/transaction

# Gemini AI Configuration
gemini.api.key=${GEMINI_API_KEY:}
gemini.api.model=gemini-2.5-flash

server.error.whitelabel.enabled=false
server.error.path=/error
server.error.include-stacktrace=never
server.error.include-message=never
server.error.include-exception=false


```properties
spring.datasource.password=your_db_password
spring.mail.username=your_email@gmail.com
spring.mail.password=your_app_password
gemini.api.key=your_gemini_key
```
3. Run: `mvn spring-boot:run`