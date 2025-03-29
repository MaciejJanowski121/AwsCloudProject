package org.example.blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import software.amazon.awssdk.regions.Region;
import org.example.blog.security.SecretsManagerUtil;


@SpringBootApplication
public class BlogApplication {

    public static void main(String[] args) {
        String password = SecretsManagerUtil.getSecret("rds-db-password-v3", Region.EU_CENTRAL_1);
        System.setProperty("spring.datasource.password", password);

        SpringApplication.run(BlogApplication.class, args);
    }
}