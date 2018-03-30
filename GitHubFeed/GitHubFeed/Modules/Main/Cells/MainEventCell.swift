//
//  MainEventCell.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 10/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import UIKit
import Kingfisher

final class MainEventCell: UITableViewCell {
    
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var eventDetailsLabel: UILabel!
    @IBOutlet weak var actorDisplayNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    func bind(eventModel: EventModel) {

        createdAtLabel.text = eventModel.event?.created_at ?? "No timestamp"
        if let rawDateString = eventModel.event?.created_at as String!, let formattedDate = ISO8601DateFormatter().date(from: rawDateString) as Date! {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            createdAtLabel.text = formatter.string(from: formattedDate)
        }
 
        actorDisplayNameLabel.text = eventModel.event?.actor?.display_login ?? "No login"
        repoNameLabel.text = eventModel.event?.repo?.name ?? "No repo name"
        
        if let url = URL(string: eventModel.event?.actor?.avatar_url ?? "") {
            avatarImageView.kf.indicatorType = IndicatorType.activity
            avatarImageView.kf.setImage(with: url)
        } else {
            avatarImageView.kf.setImage(with: nil)
            avatarImageView.image = #imageLiteral(resourceName: "AvatarPlaceholder")
        }
        
        var eventDetailsText = "No data"
        var eventDetailsValueNumber: Int?
        var eventDetailsDescriptor: String?
        if eventModel.type == EventType.push {
             if let payload = eventModel.event?.payload as? PushEventPayloadModel!,
                let commits = payload.commits as [CommitModel]! {
                eventDetailsValueNumber = commits.count
                eventDetailsDescriptor = "commit"
            }
        } else {
            if let payload = eventModel.event?.payload as? PullRequestEventPayloadModel!,
                let additions = payload.pull_request?.additions as Int! {
                eventDetailsValueNumber = additions
                eventDetailsDescriptor = "addition"
            }
        }
        
        if let eventDetailsDescriptor  = eventDetailsDescriptor as String!,
            let eventDetailsValueNumber = eventDetailsValueNumber as Int! {
            if eventDetailsValueNumber == 0 {
                eventDetailsText = "No " + eventDetailsDescriptor + "s"
            } else if eventDetailsValueNumber == 1 {
                eventDetailsText = "\(eventDetailsValueNumber) " + eventDetailsDescriptor
            } else if eventDetailsValueNumber > 1 {
                eventDetailsText = "\(eventDetailsValueNumber) " + eventDetailsDescriptor + "s"
            }
        }
        eventDetailsLabel.text = eventDetailsText
    }
}
