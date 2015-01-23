class MainController < ApplicationController
    def index
        if @current_user
            render 'main/loggedin_index'
        end

        respond_to do |format|
        	format.json
        	format.html
        	format.xml
        end
    end



    def about
        @post = Post.last
    end
end