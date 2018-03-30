//
//  PullRequestModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 12/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class PullRequestModel: Reflectable, Mappable {
    
    var additions: Int?
    var assignee: String?
    var author_association: String?
    var body: String?
    var changed_files: Int?
    var closed_at: String?
    var comments: Int?
    var comments_url: String?
    var commits: Int?
    var commits_url: String?
    var created_at: String?
    var deletions: Int?
    var diff_url: String?
    
    required init(map: Mapper) throws {
        additions = map.optionalFrom("additions")
        assignee = map.optionalFrom("assignee")
        author_association = map.optionalFrom("author_association")
        body = map.optionalFrom("body")
        changed_files = map.optionalFrom("changed_files")
        closed_at = map.optionalFrom("closed_at")
        comments = map.optionalFrom("comments")
        comments_url = map.optionalFrom("comments_url")
        commits = map.optionalFrom("commits")
        created_at = map.optionalFrom("created_at")
        deletions = map.optionalFrom("deletions")
        diff_url = map.optionalFrom("diff_url")
    }
}
