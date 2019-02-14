package hello.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

@SpringBootApplication
@EnableScheduling
public class DemoApplication {

	@Autowired
  	private ApplicationContext context;
	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

   	@Scheduled(fixedRate = 5000)
    public void selfDestructNicely() {
        ((ConfigurableApplicationContext)context).close();
    }
}

