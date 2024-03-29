package com.certificate.pass;

import java.io.IOException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.env.EnvironmentPostProcessor;
import org.springframework.boot.env.YamlPropertySourceLoader;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.PropertySource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;

public class EnvironmentPostProcessorImpl implements EnvironmentPostProcessor {

	private final YamlPropertySourceLoader loader = new YamlPropertySourceLoader();

	@Override
	public void postProcessEnvironment(ConfigurableEnvironment environment,
			SpringApplication application) {
		//Resource path = new ClassPathResource("com/secuve/agentInfo/config.yml");
		
		String osName = System.getProperty("os.name");
		Resource path = null;
		if (osName.toLowerCase().contains("windows")) {
			path = new FileSystemResource("C://ITDeveloper/config.yml");
        } else if (osName.toLowerCase().contains("linux")) {
        	path = new FileSystemResource("/sw/config.yml");
        } 
		
		PropertySource<?> propertySource = loadYaml(path);
		environment.getPropertySources().addLast(propertySource);
	}

	private PropertySource<?> loadYaml(Resource path) {
		if (!path.exists()) {
			throw new IllegalArgumentException("Resource " + path + " does not exist");
		}
		try {
			return this.loader.load("custom-resource", path).get(0);
		}
		catch (IOException ex) {
			throw new IllegalStateException(
					"Failed to load yaml configuration from " + path, ex);
		}
	}
}