module AddinfosHelper

  def text_info(id)
    @text_status = Addinfo::ADDINFO[id-1][0]
  end

end
