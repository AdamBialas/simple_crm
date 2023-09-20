class RigthsClass
  include Rigths
end
LocalRigths = RigthsClass.new

LocalRigths.create_rights_group('Company', new: 'c_new', edit: 'c_edit', delete: 'c_delete', view: 'c_view')
LocalRigths.create_rights_group('Plan', new: 'p_new', edit: 'p_edit', delete: 'p_delete', view: 'p_view',
                                        replan: 'p_change')
LocalRigths.create_rights_group('Address', new: 'a_new', edit: 'a_edit', delete: 'a_delete', view: 'a_view')
LocalRigths.create_rights_group('Contact', new: 'cs_new', edit: 'cs_edit', delete: 'cs_delete', view: 'cs_view')
LocalRigths.create_rights_group('User', admin: 'u_admin')

class ColorXBase
  include Colors
end
ColorX = ColorXBase.new


