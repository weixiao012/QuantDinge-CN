# QQ 邮箱验证码登录配置

当前平台已经支持邮箱验证码接口，QQ 邮箱登录还差真实 SMTP 凭据。不能使用 QQ 登录密码，必须使用 QQ 邮箱里生成的 SMTP 授权码。

## 当前运行地址

- 本机访问：`http://localhost:8888/#/user/login`
- 健康检查：`http://localhost:8888/api/health`
- 后端配置文件：`C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\source\QuantDinger\backend.env`

## 需要填写

```ini
SMTP_HOST=smtp.qq.com
SMTP_PORT=465
SMTP_USE_TLS=false
SMTP_USE_SSL=true
SMTP_USER=你的QQ邮箱@qq.com
SMTP_FROM=你的QQ邮箱@qq.com
SMTP_PASSWORD=QQ邮箱SMTP授权码
```

## 一键配置

在 PowerShell 里运行：

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\scripts\configure-qq-smtp.ps1
```

脚本会要求输入 QQ 邮箱和 SMTP 授权码，然后自动重启 `quantdinger-backend`。

## 验证

配置后运行：

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\scripts\test-email-code.ps1 -Email 你的QQ邮箱@qq.com
```

如果 SMTP 授权码正确，接口会返回发送成功，并且邮箱会收到验证码。
