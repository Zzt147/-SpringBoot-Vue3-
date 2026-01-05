package llp.spring.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import java.util.Random;

@Service
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    // 读取配置文件中的发送者邮箱
    @Value("${spring.mail.username}")
    private String from;

    /**
     * 发送验证码
     * @param to 收件人
     * @param code 验证码
     */
    public void sendCode(String to, String code) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(to);
        message.setSubject("【你的博客名】注册验证码");
        message.setText("欢迎注册，您的验证码是：" + code + "。有效时间为5分钟，请勿泄露给他人。");
        mailSender.send(message);
    }

    // 生成6位随机数字
    public String generateCode() {
        Random random = new Random();
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            code.append(random.nextInt(10));
        }
        return code.toString();
    }
}