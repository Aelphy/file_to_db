FileToDb::Application.routes.draw do
  root 'entities#index'

  get '/total_scale' => 'entities#total_scale', as: :total_scale
  get '/file_scale' => 'entities#file_scale', as: :file_scale
  get '/total_file_scale' => 'entities#total_file_scale', as: :total_file_scale
end
