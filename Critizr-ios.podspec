Pod::Spec.new do |s|

  s.name         = "Critizr-ios"
  s.version      = "1.2.4"
  s.summary      = "Donne accès à l'ensemble des fonctionnalités Critizr pour vos applications iOS."
  s.description  = "Le SDK iOS vous permet :
D’ouvrir une interface d’envoi de feedbacks pour un point de vente donné
D’ouvrir une interface Store Locator
D’ouvrir une interface Store Display
D’obtenir la note de relation client et de satiasfaction d’un point de vente"

  s.license      = { :type => 'BSD', :text => "LICENSE.txt" }
  s.homepage     = "http://developers.critizr.com/docs/ios_sdk.html"
  s.screenshots  = "http://developers.critizr.com/images/illustrations/sdk_ios.svg"
  s.author             = { "Guillaume Boufflers" => "guillaume.boufflers@critizr.com" }

  s.platform     = :ios
  s.source       = { :git => "https://github.com/critizr/critizr-ios-pod.git", :tag => "1.2.4" }
  s.vendored_frameworks = "Critizr.framework"
  s.requires_arc = true

end
