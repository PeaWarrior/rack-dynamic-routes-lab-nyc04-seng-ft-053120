class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            item = @@items.find do |item|
                item.name == item_name
            end
            item ? (resp.write "#{item.price}") : item_not_found
            # if item
            #     resp.write "#{item.price}"
            # else
            #     resp.write "Item not found"
            #     resp.status = 400
            # end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end

    def item_not_found
        resp.write "Item not found"
        resp.status = 400
    end
end