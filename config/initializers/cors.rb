Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: ["X-User-Email", "Content-Type", "X-User-Token"],
      methods: [:get, :options, :head]
  end
end
