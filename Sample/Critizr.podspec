Pod::Spec.new do |s|

  s.name         = "Critizr"
  s.version      = "1.0.1"
  s.summary      = "Donne accès à l'ensemble des fonctionnalités Critizr pour vos applications iOS."
  s.description  = "Le SDK iOS vous permet :
D’ouvrir une interface d’envoi de feedbacks pour un point de vente donné
D’ouvrir une interface Store Locator
D’obtenir la note de relation client d’un point de vente"

  s.license      = { :type => 'BSD', :text => "LICENSE.txt" }
  s.homepage     = "http://developers.critizr.com/docs/ios_sdk.html"
  s.screenshots  = "http://developers.critizr.com/images/ios_sdk.png"
  s.author             = { "Jean-Philippe DESCAMPS" => "jeanphilippe.descamps@critizr.com" }
  s.social_media_url   = "http://twitter.com/jeanphilipp"

  s.platform     = :ios
  s.source       = { :git => "https://github.com/critizr/critizr-ios-sdk-private.git", :tag => "v1.0.1" }
  s.source_files  = "Critizr/**/*.{h,m}", "Critizr/*.{h,m}"
  s.requires_arc = true

end
