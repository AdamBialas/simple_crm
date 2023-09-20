module Rigths
  @@list = {}

  def create_rights_group(name, **rights)
    # dodanie uprawnień jako consty do modułu
    m = Module.new
    rights.each do |key, value|
      m.const_set(key.capitalize, value)
      @@list[name] = m
    end
  end

  # zdefiniowanie pomocniczych metod
  def list
    out = {}
    @@list.each do |_key, value|
      out[_key.to_s] = value.constants(false).map { |s| { s.to_s => value.const_get(s) } }
    end
    p out
    out
  end

  def code(name, _rigth)
    if @@list[name.to_s].constants(false).include?(_rigth.to_s.capitalize.to_sym)
      @@list[name.to_s].const_get(_rigth.to_s.capitalize.to_sym)
    end
  end

  def validate(user_rights, _name, _role)
    user_rights.split(',').include?("role_#{code(_name, _role)}")
  end
end
