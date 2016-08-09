Pod::Spec.new do |s|

  s.name         = "Critizr"
  s.version      = "1.0"
  s.summary      = "Donne accès à l'ensemble des fonctionnalités Critizr pour vos applications iOS."
  s.description  = "Le SDK iOS vous permet :
D’ouvrir une interface d’envoi de feedbacks pour un point de vente donné
D’ouvrir une interface Store Locator
D’obtenir la note de relation client d’un point de vente"

  s.license      = { :type => 'BSD', :text => "LICENSE.txt" }
  s.homepage     = "http://developers.critizr.com/docs/ios_sdk.html"
  s.screenshots  = "http://developers.critizr.com/images/illustrations/sdk_ios.svg"
  s.author             = { "Jean-Philippe DESCAMPS" => "jeanphilippe.descamps@critizr.com" }

  s.platform     = :ios
  s.source       = { :git => "https://github.com/critizr/critizr-ios-pod.git", :tag => "v1.0" }
  s.vendored_frameworks = "Critizr.framework"
  s.requires_arc = true

end
