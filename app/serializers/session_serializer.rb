class SessionSerializer < ActiveModel::Serializer
  attributes :id,:name,:admin,:token

  def token
    object.authentication_token
  end
end
