class PinboardStore

  def initialize
    @host = 'localhost'
    @port = 27017
    @db_name = 'pinboard'
    @client = Mongo::MongoClient.new(@localhost, @port)
    @db = @client[@db_name]
  end

  def upsert(post)
    coll = @db['archive']
    coll.update(
      { :url => post.href },
      {
        :url => post.href,
        :description => post.description,
        :extended => post.extended,
        :tags => post.tag,
        :time => post.time.strftime("%FT%T%:z")
      },
      { :upsert => true }
    )
  end

end