# Scripts

## configure-qq-smtp.ps1

交互式写入 QQ 邮箱 SMTP 配置，并重启 `quantdinger-backend`。

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\scripts\configure-qq-smtp.ps1
```

需要输入：

- QQ 邮箱地址
- QQ 邮箱 SMTP 授权码

## test-email-code.ps1

测试邮箱验证码发送接口。

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\scripts\test-email-code.ps1 -Email 你的QQ邮箱@qq.com
```

## cloudflare-login.ps1

打开 Cloudflare 登录流程，用于生成本机 `cert.pem`。

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\scripts\cloudflare-login.ps1
```

## create-cloudflare-tunnel.ps1

创建 Cloudflare 命名隧道，并把域名绑定到本机 `http://localhost:8888`。

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\scripts\create-cloudflare-tunnel.ps1 -TunnelName quantdinger-cn -Hostname quantdinger.example.com
```
