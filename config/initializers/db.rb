uri = ENV['MONGOHQ_URL'] || ENV['MONGOLAB_URI'] || ENV['MONGODB_URI'] || ENV['MONGO_URL'] || "mongodb://localhost:27017/Afraid_#{Afraid.env}"

MongoMapper.setup({"#{Afraid.env}" => {'uri' => uri}}, Afraid.env)
