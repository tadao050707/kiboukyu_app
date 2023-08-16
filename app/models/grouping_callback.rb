class GroupingCallback
  def before_update(grouping)
    target_grouping = Grouping.find(grouping.id)
    binding.pry
    if target_grouping.group.owner == target_grouping.user
      throw(:abort)
    end
  end
end