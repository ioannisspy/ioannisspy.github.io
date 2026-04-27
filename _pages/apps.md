---
layout: archive
title: "My Apps"
permalink: /apps/
author_profile: true
---

## Chat-SEC

**Fast and accurate, AI-powered financial document analysis for teaching and research.**

Chat-SEC lets students and faculty ask targeted questions about specific segments of firms' SEC filings. It is hosted on a private server and pulls from a separate GitHub repository.

<p>
  <a class="btn btn--primary" href="https://chat-sec.com/" target="_blank" rel="noopener" onclick="window.open(this.href, 'chat-sec', 'noopener,noreferrer,width=1200,height=800'); return false;">Open Chat-SEC</a>
</p>

Chat-SEC uses a four-step retrieval process:

1. **Retrieve** exact SEC filings by ticker, date, and form type.
2. **Extract** relevant sections, such as Risk Factors, MD&A, and Financial Statements.
3. **Feed** filtered content to an LLM for analysis.
4. **Chat** interactively with the user about the filing.

By grounding responses in verified filing text, Chat-SEC is designed to reduce hallucinations and avoid the "lost in the middle" problem that can arise when generic AI tools process very long filings.