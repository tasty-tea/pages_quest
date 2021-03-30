# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_root
  before_action :set_page, only: %i[show edit update destroy]
  before_action :set_parent, only: %i[create new]

  include PagesHelper

  # GET /pages or /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1 or /pages/1.json
  def show; end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    @page.body = deconstruct_html(@page.body)
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)
    @page.parent = @parent
    @page.body = construct_html(page_params[:body])

    # Create root pages with this condition
    @page.path = generate_path

    respond_to do |format|
      if @page.save
        format.html { redirect_to "/#{@page.path}", notice: 'Page was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      @page.assign_attributes(page_params)
      @page.body = construct_html(page_params[:body])
      if @page.save
        format.html { redirect_to "/#{@page.path}", notice: 'Page was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
    end
  end

  private

  def set_root
    @root = Page.find_by nesting: 0
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find_by path: params[:page_path]
    not_found unless @page
    @page
  end

  # Parent is the page we're branching from
  def set_parent
    if params[:page_path].nil?
      @parent = @root
    else
      parent_path = params[:page_path]
      @parent = Page.find_by path: parent_path
    end
  end

  def generate_path
    if @parent == @root
      @page.name
    else
      @parent.path + '/' + @page.name
    end
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:name, :head, :body, :path)
  end
end
