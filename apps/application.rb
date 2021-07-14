class Application

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path.match(/animals/) && req.get?
        animals = Animal.all.map do |animal|
          {id: animal.id, species: animal.species, name: animal.name, age: animal.age, breed: animal.breed, adopted: animal.adopted, shelter_id: animal.shelter_id}
        end

        return [200, { 'Content-Type' => 'application/json' }, [ {:animals => animals}.to_json ]]  

      elsif req.path.match(/shelters/) && req.get?
        shelters = Shelter.all.map do |shelter|
            {id: shelter.id, name: shelter.name, location_id: shelter.location_id}
        end

        return [200, { 'Content-Type' => 'application/json' }, [ {:shelters => shelters}.to_json ]]  

      elsif req.path.match(/visitors/) && req.get?
        visitors = Visitor.all.map do |visitor|
            {id: visitor.id, name: visitor.name, password: visitor.password, location_id: visitor.location_id}
        end

        return [200, { 'Content-Type' => 'application/json' }, [ {:visitors => visitors}.to_json ]] 

      elsif req.path.match(/adoptions/) && req.get?
        adoptions = Adoption.all.map do |adoption|
            {id: adoption.id, date: adoption.date, price: adoption.price, animal_id: adoption.animal_id, visitor_id: adoption.visitor_id}
        end

        return [200, { 'Content-Type' => 'application/json' }, [ {:adoptions => adoptions}.to_json ]] 

      elsif req.path.match(/locations/) && req.get?
        locations = Location.all.map do |location|
            {id: location.id, zip_code: location.zip_code}
        end

        return [200, { 'Content-Type' => 'application/json' }, [ {:locations => locations}.to_json ]]
        
      else
        resp.write "Path Not Found"
      end

      resp.finish

    end
end