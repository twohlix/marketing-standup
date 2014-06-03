MANDRILL_CONFIG = YAML.load_file("#{::Rails.root}/config/mandrill.yml")[::Rails.env]
