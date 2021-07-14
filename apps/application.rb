class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/visitors/) && req.get?
            visitors = Visitor.all.collect do |visitor|
                {id: visitor.id, name: visitor.name, location_id: visitor.location_id, password: visitor.password}
            end 
            
           return [200, {'Content-type' => 'application/json'}, [{visitors: visitors}.to_json]]

        elsif req.path.match(/shelters/) && req.get?
            shelters = Shelter.all.map do |shelter|
                {id: shelter.id, name: shelter.name, location_id: shelter.location_id}
            end

            return [200, { 'Content-Type' => 'application/json' }, [ {:shelters => shelters}.to_json ]]  
        else
            resp.write "Path Not Found"

        end
            resp.finish
    end
end