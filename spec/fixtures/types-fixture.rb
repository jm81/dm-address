class TypesFixture
  include DataMapper::Resource

  property :id, Serial
  property :phone, PhoneNumber
  property :zip, ZipCode
end
