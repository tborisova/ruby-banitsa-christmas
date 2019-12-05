class GeneratePresent

  def execute(letter)
    if letter.key?('KidId')
      child_id = letter['KidId']

      child = Child.find_by child_id: child_id

      if child.blank?
        SendNotificationToElvesJob.perform_later child_id
        return
      end

      if Coal.exists?('created_at::date >= :beginning_of_the_year AND child_id = :child_id', Time.beginning_of_the_year, child_id)
        SendNotificationToMrsKringleJob.perform_later child.id
        return
      end

      presents =
        letter['Wishes'].map do |present|
          {
            wish: present['Wish'],
            new_for_this_year: present['NewForThisYear'],
          }
        end

      present_information = {
        child_name: letter['KidName'],
        presents: presents
        country: letter['Country'],
        city: letter['City'],
        address: letter['Address'],
        has_roof: letter['HasRoof'],
        child_id: child_id
      }
    else
      child = Child.find_by child_id: ['Letters.Santa.ChildId']

      if child.blank?
        SendNotificationToElvesJob.perform_later child_id
        return
      end

      if Coal.exists?('created_at::date >= :beginning_of_the_year AND child_id = :child_id', Time.beginning_of_the_year, child_id)
        SendNotificationToMrsKringleJob.perform_later child_id
        return
      end

      presents =
        letter['Letters.Santa.Presents'].map do |present|
          {
            wish: present['Wish'],
            new_for_this_year: present['NewForThisYear'],
          }
        end

      present_information = {
        child_name: letter['Letters.Santa.ChildName'],
        presents: presents
        country: letter['Letters.Santa.Country'],
        city: letter['Letters.Santa.City'],
        address: letter['Letters.Santa.Address'],
        has_roof: letter['Letters.Santa.HasRoof'],
        child_id: child_id
      }
    end

    present = PresentWishes.create! present_information

    if child.age > 18
      SendNotificationToDestinyJob.perform_later present.id
    end

    SendPresentToSantaJob.perform_later present.id
  end
end
