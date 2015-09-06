class CreditLinesController < ApplicationController
  require 'will_paginate/array'
  before_filter :authenticate_admin!

  # GET /credit_lines
  # GET /credit_lines.json
  def index
    @credit_lines = CreditLine.find_all_by_admin_id(current_admin.id)
    @payment_plans= PaymentPlan.order('created_at DESC').find_all_by_admin_id(current_admin.id)
    @payment_plans = @payment_plans.paginate(:page => 1, :per_page => 50)
    @payment_plans.sort_by { ||}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credit_lines }
    end
  end

  # GET /credit_lines/1
  # GET /credit_lines/1.json
  def show
    @credit_line = CreditLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit_line }
    end
  end

  # GET /credit_lines/new
  # GET /credit_lines/new.json
  def new

    #@credit_line = CreditLine.new
    @admin=Admin.find(current_admin.id)
    @credit_line = @admin.credit_lines.new

    puts (@admin.name)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit_line }
    end
  end

  # GET /credit_lines/1/edit
  def edit
    @edit=1
    @credit_line = CreditLine.find(params[:id])
  end

  # POST /credit_lines
  # POST /credit_lines.json
  def create
    @admin=Admin.find(current_admin.id)
    @credit_line = @admin.credit_lines.create(params[:credit_line])
    #@credit_line.admin=@admin.id
    respond_to do |format|
      if @credit_line.save
        format.html { redirect_to @credit_line, notice: 'Credit line was successfully created.' }
        format.json { render json: @credit_line, status: :created, location: @credit_line }
      else
        format.html { render action: "new" }
        format.json { render json: @credit_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /credit_lines/1
  # PUT /credit_lines/1.json
  def update
    puts ('entro al update')
    @credit_line = CreditLine.find(params[:id])

    respond_to do |format|
      if @credit_line.update_attributes(params[:credit_line])
        format.html { redirect_to @credit_line, notice: 'Credit line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credit_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_lines/1
  # DELETE /credit_lines/1.json
  def destroy
    @credit_line = CreditLine.find(params[:id])
    @credit_line.destroy

    respond_to do |format|
      format.html { redirect_to credit_lines_url }
      format.json { head :no_content }
    end
  end
end
