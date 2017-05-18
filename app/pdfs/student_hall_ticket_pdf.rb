class StudentHallTicketPdf < Prawn::Document
  def initialize(student_obj,course_name,school_logo,school,date_format, mg_examination_detail_id)
    super({:page_size => [595 ,842]})
    @student_name = student_obj 
    @mg_examination_detail_id=mg_examination_detail_id
    @course_name = course_name
    @batch_name = MgBatch.find_by(:id=>student_obj.mg_batch_id)
    @examination_detail = MgExaminationDetail.find_by(:id=>mg_examination_detail_id)
    @time_table=MgExaminationTimeTable.where(:mg_examination_detail_id=>mg_examination_detail_id, :is_deleted=>0, :mg_school_id=>school.try(:id), :mg_batch_id=>student_obj.mg_batch_id).order(:date, :start_time)
    @school_logo = school_logo
    @school = school
    @date_format = date_format
    @stu_photo=@student_name.avatar.url(:medium, timestamp: false)
    @mylen = @school.school_name
    @count=0
    logo
    #student_detail
    #student_image
    #table_content
    # footer
    
  end

  def logo 
    y_position = cursor - 0
    y_position1 = cursor - 15
    y_position2 = cursor - 115
    y_position3 = cursor - 140
    y_position4 = cursor - 190
         

    repeat :all do
      bounding_box([0, y_position], :width => 270, :height => 300) do
        font "Helvetica"
        if File.exists?("#{Rails.root}/public/#{@school_logo}")
          image ("#{Rails.root}/public/#{@school_logo}"),:width=>70
        else
          image ("#{Rails.root}/app/assets/images/logo.jpg"),:width=>70   
        end 
      end      

      bounding_box([70, y_position1], :width => 400, :height => 300) do
        text @school.school_name, :align => :center, :size => 20,:inline_format => true
      end
       
      bounding_box([0, y_position2], :width => 510, :height => 300) do
        stroke_horizontal_rule
      end
      
      footer
    end
    bounding_box([400, y_position3], :width => 580, :height => 300) do
        if File.exists?("#{Rails.root}/public/#{@stu_photo}")
          image ("#{Rails.root}/public/#{@stu_photo}"),:width=>70
        else
          image ("#{Rails.root}/app/assets/images/student.png"),:width=>70   
        end
    end

    bounding_box([0, y_position3], :width => 270, :height => 300) do
      text "Student Name: #{@student_name.first_name.capitalize} #{@student_name.middle_name.capitalize} #{@student_name.last_name.capitalize}", :size => 12, style: :bold
      text "Date of Birth: #{@student_name.date_of_birth.strftime(@date_format)}", :size => 12, style: :bold
      text "Semester: #{@course_name.try(:course_name)}", :size => 12, style: :bold
      text "Student ID: #{@student_name.try(:admission_number)}", :size => 12, style: :bold
    end

  

    bounding_box([0, y_position4], :width => 500, :height => 530) do
      table_content
    end
  end

    


    # def text_content
    #   # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    #   y_position = cursor - 50

    #   # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    #   bounding_box([0, y_position], :width => 270, :height => 300) do
    #     text "Lorem ipsum", size: 15, style: :bold
    #     text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum semper placerat. Aenean mattis fringilla risus ut fermentum. Fusce posuere dictum venenatis. Aliquam id tincidunt ante, eu pretium eros. Sed eget risus a nisl aliquet scelerisque sit amet id nisi. Praesent porta molestie ipsum, ac commodo erat hendrerit nec. Nullam interdum ipsum a quam euismod, at consequat libero bibendum. Nam at nulla fermentum, congue lectus ut, pulvinar nisl. Curabitur consectetur quis libero id laoreet. Fusce dictum metus et orci pretium, vel imperdiet est viverra. Morbi vitae libero in tortor mattis commodo. Ut sodales libero erat, at gravida enim rhoncus ut."
    #   end

    #   # bounding_box([300, y_position], :width => 270, :height => 300) do
    #   #   text "Duis vel", size: 15, style: :bold
    #   #   text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
    #   # end
    # end





  # def student_detail
  #    # text "Student Name: #{@student_name.first_name.capitalize} #{@student_name.middle_name.capitalize} #{@student_name.last_name.capitalize}", :size => 12
  #    # move_down 5
  #    # text "Date of Birth: #{@student_name.date_of_birth.strftime(@date_format)}", :size => 12
  #    # move_down 5
  #    # text "Semester: #{@course_name.try(:course_name)}", :size => 12
  #    # move_down 15     
  # end 

 
  def table_content
      table product_rows do
        row(0).font_style = :bold
        self.header = true
        self.row_colors = ['DDDDDD', 'FFFFFF']
        self.column_widths = [50, 150, 100,100,100]
      end

  end
 
  def product_rows
    move_down(25)
    [['SR.No', 'Subject Name', 'Date','Time','Signature']] +
    @time_table.map do |c|
      [@count+=1,MgSubject.find_by(:id=>c.try(:mg_subject_id)).try(:subject_name) , c.date.present? ? c.try(:date).strftime(@school.date_format) : '' ,"#{ c.start_time.present? ?  c.try(:start_time).strftime('%I:%M%p') : ''}-#{ c.end_time.present? ?  c.try(:end_time).strftime('%I:%M%p') : ''}",'']
    end

  end
  def product_rows_ee
    
  end

  def footer
    bounding_box [bounds.left, bounds.bottom + 45], :width  => bounds.width do
      font "Helvetica"
      stroke_horizontal_rule
      move_down(5)
      move_down 12
      
      draw_text "Terms & Conditions| Privacy Policy| About Us| Contact Us       Powered By - ©", :at => [30,3]
      image "#{Rails.root}/app/assets/images/mindcom-logo.png", :at=>[450,15], :width => 45, :align => :right
    end
  end
end