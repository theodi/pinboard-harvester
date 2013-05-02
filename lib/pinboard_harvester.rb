class PinboardHarvester

  @queue = 'harvest'

  def self.perform(days=nil)

    @s = PinboardStore.new()

    p = Pinboard::Client.new(:username => ENV['PINBOARD_USERNAME'], :password => ENV['PINBOARD_PASSWORD'])
    if days.nil?
      posts = p.posts
    else
      now = Date.today
      from = now - days
      posts = p.posts(:fromdt => from)
    end    

    puts 'harvested'
    posts.each do |post|
      @s.upsert(post)
    end

    # enqueue next job
    #Resque.enqueue_in(120.seconds, PinboardHarvester, days)

  end

end