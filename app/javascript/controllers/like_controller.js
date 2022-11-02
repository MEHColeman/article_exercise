import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static values = {
    articleid: Number
  }

  connect() {
    console.log("Stimulus like controller connected")
  }

  like () {
    console.log("Liking article " + this.articleidValue)
    let params = new URLSearchParams()
    params.append("article_id", this.articleidValue)
    fetch(`/likes/create/?${params}`, {
    method: 'GET'
    })
      .then(response => response.text())
      .then(html => this.element.outerHTML = html)
  }

  unlike () {
    console.log("Unliking article " + this.articleidValue)
    let params = new URLSearchParams()
    params.append("article_id", this.articleidValue)
    fetch(`/likes/destroy/?${params}`, {
    method: 'GET'
    })
      .then(response => response.text())
      .then(html => this.element.outerHTML = html)
  }
}
