actions :enforce

attribute :name, :required => true

def initialize(*args)
  super
  @action = :enforce
end
