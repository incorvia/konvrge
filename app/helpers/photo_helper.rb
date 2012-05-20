module PhotoHelper
  def wall_last(counter)
    if (counter + 1) % 3 == 0
      "last"
    end
  end
end
