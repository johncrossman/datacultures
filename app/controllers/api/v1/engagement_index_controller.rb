class Api::V1::EngagementIndexController < ApplicationController

  require 'percentile'
  using Percentile

  skip_before_filter  :verify_authenticity_token
  ALL_SEEING_ROLES = ["ContentDeveloper", "urn:lti:role:ims/lis/TeachingAssistant", "Instructor"]

  def index
    render json: engagement_index
  end

  private

  def engagement_index
    students = Student.visible_to(user_id: current_user.canvas_id, all_seeing: all_seeing?)
    activities = Activity.visible_to(user_id: current_user.canvas_id, all_seeing: all_seeing?)
    student_points = activities.student_scores
    all_student_scores = Activity.student_scores.values
    last_activity_dates = activities.select(:canvas_updated_at, :canvas_user_id).
        group(:canvas_user_id).maximum(:canvas_updated_at)
    students_array = []
    student_count  = Student.count
    students.each do |student|
      students_array << student_data(last_activity_dates, student, student_points, all_student_scores, student_count)
    end
    engagement_index_json = {}
    engagement_index_json["students"] = students_array.sort_by {|h| h[:id]}
    engagement_index_json["current_canvas_user"] = students.where({canvas_user_id: current_user.canvas_id}).first
    engagement_index_json["current_canvas_user_points"] = student_points[current_user.canvas_id] || 0
    engagement_index_json
  end

  def student_data(last_activity_dates, student, student_points, all_student_scores, student_count)
    student_hash = {}
    id = student.canvas_user_id
    student_hash[:id] = id
    student_hash[:name] = student.name
    student_hash[:sortable_name] = student.sortable_name
    student_hash[:points] = student_points[id] || 0
    student_hash[:section] = student.section
    student_hash[:share] = student.share
    student_hash[:percentile] = all_student_scores.rank(score: student_hash[:points], fill_zeroes_to_size: student_count)
    student_hash[:last_activity_date] = last_activity_dates[id] ? (last_activity_dates[id].to_time.to_i * 1000) : 0
    student_hash
  end

  def all_seeing?
    !(ALL_SEEING_ROLES & current_user.user_roles).empty?
  end
end
