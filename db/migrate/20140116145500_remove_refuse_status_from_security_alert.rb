class RemoveRefuseStatusFromSecurityAlert < ActiveRecord::Migration
  def change
    SecurityAlert.all.each do |sa|
      if sa.status == 3
        sa.status == 2
      end
    end
  end
end
