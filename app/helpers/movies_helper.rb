module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sort_color(header)
    if(params[:sort].to_s == header)
      return 'hilite'
    else
      return nil
    end
  end
end
