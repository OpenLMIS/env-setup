action :enforce do
  states = {:enable => 1, :disable => 0}; states.default = 1
  value = states[new_resource.name.to_sym]
  
  execute "set /selinux/enforce to #{value}" do
    command "echo #{value} > /selinux/enforce"
    not_if "grep #{value} /selinux/enforce"
    notifies :create ,"ruby_block[update_notification]"
  end
  ruby_block "update_notification" do 
    block do
        new_resource.updated_by_last_action(true)
    end
    action :nothing
  end
end
