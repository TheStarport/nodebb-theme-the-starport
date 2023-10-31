<div class="d-flex flex-wrap gap-2 align-items-center" component="search/filters">
	<!-- category filter -->
	<div class="post-search-item">
		<div component="category/filter" class="dropdown" data-filter-name="category">
			<a component="category/filter/button" class="filter-btn btn btn-light btn-sm border {{{ if filters.categories.active }}}active-filter{{{ end }}} dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
				<span class="filter-label">{{{ if filters.categories.active }}}{filters.categories.label}{{{ else }}}[[search:categories]]{{{ end }}}</span>
				<span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm">
				<li class="px-3 py-1 mb-2 d-flex flex-column gap-2">
					<div component="category-selector-search">
						<input type="text" class="form-control" component="category/filter/search" placeholder="[[search:type_a_category]]">
					</div>
				</li>
				<div component="category/list" class="overflow-auto" style="max-height: 350px;"></div>
				<div class="px-3 py-1">
					<div class="form-check">
						<input id="search-children" class="form-check-input" type="checkbox"/>
						<label class="form-check-label" for="search-children">[[search:search_child_categories]]</label>
					</div>
				</div>
			</ul>
		</div>
	</div>


	<!-- tag filter -->
	<div class="post-search-item">
		<div component="tag/filter" class="dropdown" data-filter-name="tag">
			<a component="tag/filter/button" class="filter-btn btn btn-light btn-sm border {{{ if filters.tags.active }}}active-filter{{{ end }}} dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
				<span class="filter-label">{{{ if filters.tags.active }}}{filters.tags.label}{{{ else }}}[[search:tags]]{{{ end }}}</span>
				<span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm" style="width: 350px;">
				<li class="px-3 py-1 d-flex flex-column gap-2">
					<input type="text" class="form-control" component="tag/filter/search" placeholder="[[search:type_a_tag]]">
					<div component="tag/filter/selected" class="d-flex flex-wrap gap-2">
						{{{ each tagFilterSelected }}}
						<div class="d-flex px-2 py-1 rounded-1 text-bg-primary gap-2 align-items-center text-sm">
							<div>{./valueEscaped}</div>
							<button component="tag/filter/delete" data-tag="{./valueEscaped}" class="btn btn-primary btn-sm py-0"><i class="fa fa-times fa-xs"></i></button>
						</div>
						{{{ end }}}
					</div>
					<hr/>
					<div component="tag/filter/results" class="d-flex flex-wrap gap-2">
						{{{ each tagFilterResults }}}
						<button class="btn btn-light btn-sm border" data-tag="{./valueEscaped}">{./valueEscaped}</button>
						{{{ end }}}
					</div>
				</li>
			</ul>
		</div>
	</div>

	<!-- user name filter -->
	<div class="post-search-item">
		<div component="user/filter" class="dropdown" data-filter-name="user">
			<a component="user/filter/button" class="filter-btn btn btn-light btn-sm border {{{ if filters.users.active }}}active-filter{{{ end }}} dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
				<span class="filter-label">{{{ if filters.users.active }}}{filters.users.label}{{{ else }}}[[search:posted-by]]{{{ end }}}</span>
				<span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm" style="width: 350px;">
				<li class="px-3 py-1 d-flex flex-column gap-2">
					<input type="text" class="form-control" component="user/filter/search" placeholder="[[search:type_a_username]]">
					<div component="user/filter/selected" class="d-flex flex-wrap gap-2">
						{{{ each userFilterSelected }}}
						<div class="d-flex px-2 py-1 rounded-1 text-bg-primary gap-2 align-items-center text-sm">
							{buildAvatar(@value, "16px", true)} {./username}
							<button component="user/filter/delete" data-uid="{./uid}" class="btn btn-primary btn-sm py-0"><i class="fa fa-times fa-xs"></i></button>
						</div>
						{{{ end }}}
					</div>
					<hr/>
					<div component="user/filter/results" class="d-flex flex-wrap gap-2">
						{{{ each userFilterResults }}}
						<button class="btn btn-light btn-sm border" data-uid="{./uid}" data-username="{./username}">{buildAvatar(@value, "16px", true)} {./username}</button>
						{{{ end }}}
					</div>
				</li>
			</ul>
		</div>
	</div>


	<!-- reply count filter -->
	<div class="post-search-item">
		<div class="dropdown" data-filter-name="replies">
			<a id="reply-count-button" class="filter-btn btn btn-light btn-sm border {{{ if filters.replies.active }}}active-filter{{{ end }}} dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				<span class="filter-label">{{{ if filters.replies.active }}}{filters.replies.label}{{{ else }}}[[search:replies]]{{{ end }}}</span>
				<span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm" style="width: 300px;">
				<li class="px-3 py-1 d-flex flex-nowrap gap-2">
					<select id="reply-count-filter" class="form-select py-2 ps-2 pe-3">
						<option value="atleast">[[search:at_least]]</option>
						<option value="atmost">[[search:at_most]]</option>
					</select>
					<input id="reply-count" type="number" min="0" class="form-control py-2 ps-2 pe-3" />
				</li>
			</ul>
		</div>
	</div>

	<!-- time filter -->
	<div class="post-search-item">
		<div class="dropdown" data-filter-name="time">
			<a id="post-time-button" class="filter-btn btn btn-light btn-sm border {{{ if filters.time.active }}}active-filter{{{ end }}} dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				<span class="filter-label">{{{ if filters.time.active }}}{filters.time.label}{{{ else }}}[[search:time]]{{{ end }}}</span>
				<span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm" style="width: 350px;">
				<li class="px-3 py-1 d-flex flex-nowrap gap-2">
					<select id="post-time-filter" class="form-select py-2 ps-2 pe-3">
						<option value="newer">[[search:newer_than]]</option>
						<option value="older">[[search:older_than]]</option>
					</select>
					<select id="post-time-range" class="form-select py-2 ps-2 pe-3">
						<option value="">[[search:any_date]]</option>
						<option value="86400">[[search:yesterday]]</option>
						<option value="604800">[[search:one_week]]</option>
						<option value="1209600">[[search:two_weeks]]</option>
						<option value="2592000">[[search:one_month]]</option>
						<option value="7776000">[[search:three_months]]</option>
						<option value="15552000">[[search:six_months]]</option>
						<option value="31104000">[[search:one_year]]</option>
					</select>
				</li>
			</ul>
		</div>
	</div>

	<!-- sort filter -->
	<div class="post-search-item">
		<div class="dropdown" data-filter-name="sort">
			<a id="sort-by-button" class="filter-btn btn btn-light btn-sm border {{{ if filters.sort.active }}}active-filter{{{ end }}} dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				<span class="filter-label">{{{ if filters.sort.active }}}{filters.sort.label}{{{ else }}}[[search:sort]]{{{ end }}}</span>
				<span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm" style="width: 250px;">
				<li class="px-3 py-1 d-flex flex-column gap-2">
					<select id="post-sort-by" class="form-select py-2 ps-2 pe-3">
						<option value="relevance">[[search:relevance]]</option>
						<option value="timestamp">[[search:post_time]]</option>
						<option value="votes">[[search:votes]]</option>
						<option value="topic.lastposttime">[[search:last_reply_time]]</option>
						<option value="topic.title">[[search:topic_title]]</option>
						<option value="topic.postcount">[[search:number_of_replies]]</option>
						<option value="topic.viewcount">[[search:number_of_views]]</option>
						<option value="topic.votes">[[search:topic_votes]]</option>
						<option value="topic.timestamp">[[search:topic_start_date]]</option>
						<option value="user.username">[[search:username]]</option>
						<option value="category.name">[[search:category]]</option>
					</select>
					<select id="post-sort-direction" class="form-select py-2 ps-2 pe-3">
						<option value="desc">[[search:descending]]</option>
						<option value="asc">[[search:ascending]]</option>
					</select>
				</li>
			</ul>
		</div>
	</div>

	<!-- save & reset preferences -->
	<div class="post-search-item">
		<div class="dropdown">
			<a class="btn btn-light btn-sm border dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">[[search:save]] <span class="caret"></span>
			</a>

			<ul class="dropdown-menu p-1 text-sm" style="width: 300px;">
				<li class="px-3 py-1 d-flex flex-column gap-2">
					<button id="save-preferences" class="btn btn-primary">[[search:save_preferences]]</button>
					<button id="clear-preferences" class="btn-outline border">[[search:clear_preferences]]</button>
				</li>
			</ul>
		</div>
	</div>
</div>