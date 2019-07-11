Resque.redis = Rails.env.eq? "production" ? $redis : "localhost:6379"
